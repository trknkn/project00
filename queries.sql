
# 1.Show proteins whose are rewieved and length is greater than 200.
select name from protein where length > 200 and is_reviewed=1;

# 2.Show human proteins whose are not rewieved.
select name from protein where  is_reviewed=0 taxon_id in (
	select id from taxon where name = 'Homo sapiens'
);

# 3.Show proteins associated with metabolic disorder-related diseases.
select p.name from protein p where p.is_reviewed=1 and p.accession in (

	select d.accession 
	from disease d join protein_disease pd on d.accession = pd.accession 
	where d.mim = %metabolic disorder% )
);

 # 4.Show  proteins which has the highest number of publications.
select p.name, count(pub.pmid) from protein p join protein_publication pub on p.accession = pub.accession 
 order by count(pub.pmid) desc limit 1;

# 5.Show go terms whose are obsolute and grup them by namespaces.
select  go.name , go.namespace as terms from go_terms group by go.namespace having go.is_obsolute=1;

#6. Show Chitinase 16 protein  domains.
select p.name from domain d join protein_domain pd on pd.domain=d.pfam
 join protein p on p.accession=pd.accession where p.name='Chitinase 16';

#7. Show ids of genes whose are belong to human.
select g.gene from protein_gene g join protein p on g.accession=p.accession
 join taxon t on t.id=p.taxon_id where t.name='Homo sapiens';

#8. Show domains whose has not parents. 
select p.name from pathway p join pathway_hierarchy ph on p.id=ph.parent where ph.parent='';

#9. Show Syntaxin 16 protein cross references.
select c.crossref from protein_crossref c join protein p pn p.accession=c.accession where p.name='Syntaxin 16';

#10.Show the number of genes whose are associated with RA disease.
select count(g.acc) from protein_gene g join protein p on p.accession=g.accession
join protein_disease pd on p.accession=pd.accession
join disease d on d.accession=pd.accession where d.acronym='RA';




